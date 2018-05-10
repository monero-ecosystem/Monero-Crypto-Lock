/* Monero Authentication browser extension
 * Copyright 2018	Darcey Dale Bebber
 * Copyright 2018	Douglas Alan Bebber
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
*/
'use strict';

let currentPort,
    getPort = function(callback) {
        if (!currentPort){
            chrome.storage.sync.get(['port'], function(data) {
                currentPort = data.port || 18083;
                $('#port').val(currentPort);
                callback(currentPort);
            });
        }else{
            callback(currentPort);
        }
    },
    doSign = function(address, doSubmit) {
        getPort(function(port) {
            var v = $('#challenge').val();
            chrome.runtime.sendMessage({
                sign: {
                    challenge: v,
                    port: port
                }
            }, function(responseParent) {
                if (address){
                    chrome.tabs.query({
                        active: true,
                        currentWindow: true
                    }, function(tabs) {
                        chrome.tabs.sendMessage(
                            tabs[0].id, {
                                from: 'popup',
                                subject: 'Signed',
                                address: address,
                                signature: responseParent.signature,
                                doSubmit: doSubmit
                            },
                            function() {});
                    });
                $('#sig').val(responseParent.signature);
                }
            });
        });
    },
    copyToClipboard = function(element, type) {
        let $temp = $("<input>");
        $("body").append($temp);
        if (type==='val'){
            $temp.val($(element).val()).select();
        }else{
            $temp.val($(element).text()).select();
        }
        document.execCommand("copy");
        $temp.remove();
    },
    getAddress = function(cb, options){
        getPort(function(port) {
            chrome.runtime.sendMessage({
                getaddress: {
                    port: port
                }
            }, function(response) {
                $('#myaddress').val((response && response.address)?response.address:'Error getting Address');
                if (cb){
                    if (response && response.address){
                        if (options){
                            cb(response.address, options);
                        }else{
                            cb(response.address);
                        }
                    }else{
                        cb();
                    }
                }
            });
        });
    },refreshPopupDom = function(info){
        getPort(function(port) {
            chrome.runtime.sendMessage({
                getaddress: {
                    port: port
                }
            }, function(response) {
                if (response && response.address) {
                    $('#signHeader, #signPanel')
                        .removeClass( "ui-state-disabled" );
                    $('#challenge').val((info && info.challenge)?info.challenge:'');
                    $('#signandsend').css('visibility', (info && info.submitButton)?'visible':'hidden');
                    $('#connectionstatus').text('Connected')
                        .removeClass('connectionstatusnotconnected')
                        .addClass('connectionstatusconnected');

                    toggleSignButtons();
                    getAddress(function(){});
                } else{
                    $('#signHeader, #signPanel')
                        .addClass( "ui-state-disabled" );
                    $('#connectionstatus').text('Not Connected')
                        .addClass('connectionstatusnotconnected')
                        .removeClass('connectionstatusconnected');

                    toggleSignButtons();
                }
            });
        });
    },toggleSignButtons = function(e){
        setTimeout(function () {
            if ($( "#challenge" ).val().trim().length>0){
                $('#signit, #signandsend').removeClass( "ui-state-disabled" );
            }else{
                $('#signit, #signandsend').addClass( "ui-state-disabled" );
            }
        },100);
    }

$(function() {
    $( ".buttonbar" ).controlgroup();
    $("#accordion").accordion({
        heightStyle: "content",
        activate: function(event, ui) {
            if (ui.newHeader.context.innerText === 'Settings') {
                getPort(function(port) {});
            } else if (ui.newHeader.context.innerText === 'My Address') {
                getAddress();
            }
        },
        beforeActivate: function( event, ui ) {
            var challenge = $('#challenge').val(),
                submitButton = document.getElementById('signandsend').style.visibility!=='hidden',
                info;

            if (challenge!='' || submitButton){
                info = {
                    challenge:challenge,
                    submitButton:submitButton
                }
            }
            refreshPopupDom(info);
        }
    });
    $( "#challenge" ).change(toggleSignButtons);
    $( "#challenge" ).bind('paste', toggleSignButtons);
    $('#challenge').keyup(function(e) {
        //if (e.keyCode == 8 || e.keyCode == 46) { //backspace and delete key
            toggleSignButtons();
        //} else { // rest ignore
        //    e.preventDefault();
        //}
    });
    $('#copychallenge').click(function(element){
        copyToClipboard('#challenge', 'val');
    });
    $('#copyaddress').click(function(element){
        copyToClipboard('#myaddress', 'val');
    });
    $('#copysig').click(function(element){
        copyToClipboard('#sig', 'val');
    });
    $('#signit').click(function(element){
        getAddress(doSign);
    });
    $('#signandsend').click(function(element){
        getAddress(doSign, true);
    });
    $('#portsave').click(function(element){
        chrome.storage.sync.set({
            port: parseInt($('#port').val())
        });
    });
    $('#testconnectionbutton').click(function(element){
        refreshPopupDom();
    });
    chrome.storage.onChanged.addListener(function(changes, namespace) {
        for (var key in changes) {
          var storageChange = changes[key];
          if (key==='port'){
            var challenge = $('#challenge').val(),
            submitButton = document.getElementById('signandsend').style.visibility!=='hidden',
            info;

            currentPort=storageChange.newValue;
            if (challenge!=='' || submitButton){
                info = {
                    challenge:challenge,
                    submitButton:submitButton
                }
            }
            refreshPopupDom(info);
          }
        }
      });
    // $( "#copysig" ).button({
    //     icon: "ui-icon ui-icon-gear",
    //     showLabel: false
    //   });
});
window.addEventListener('DOMContentLoaded', function() {
    chrome.tabs.query({
        active: true,
        currentWindow: true
    }, function(tabs) {
        chrome.tabs.sendMessage(
            tabs[0].id, {
                from: 'popup',
                subject: 'DOMInfo'
            },
            refreshPopupDom);
    });
});
