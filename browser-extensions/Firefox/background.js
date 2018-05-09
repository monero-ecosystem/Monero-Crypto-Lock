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
browser.runtime.onInstalled.addListener(function() {
  browser.runtime.onMessage.addListener(function(message, sender, sendResponse) {
      let execMoneroAction = function(moneroPortWallet, moneroActionWallet, moneroParamsWallet){
        
          new $.JsonRpcClient({ajaxUrl: 'http://localhost:' +  moneroPortWallet + '/json_rpc'}).call(
            moneroActionWallet, moneroParamsWallet,
            function (result) {
              if (result){
                sendResponse(result);
              }else{
                sendResponse();  
              }
            },
            function (error) {
              console.log('ERROR');
              sendResponse();
            }
          );
      };

    if ((message.from && message.from === 'content') && (message.subject && message.subject === 'showPageAction')) {
      // Enable the page-action for the requesting tab
      browser.pageAction.show(sender.tab.id);
    }else if (message.sign) {
      execMoneroAction(message.sign.port, 'sign', {"data":message.sign.challenge});     
    }else if (message.getaddress){
      //execMoneroAction(message.getaddress.port, 'getaddress', []);
      var req = new XMLHttpRequest (); 
      req.open ('POST', 'http://localhost:' + message.getaddress.port + '/json_rpc'); 
      req.onreadystatechange = function (aEvt) { 
        if (req.readyState == 4) {
            if (req.status != 200) {
              sendResponse();
            } else{
              sendResponse(JSON.parse(req.responseText).result);
            }
        }
      }; 
      req.timeout = 3000;
      req.ontimeout = function (e) {
        sendResponse();
      };
      req.send ('{"jsonrpc":"2.0","id":"0","method":"getaddress"}');
    } 
    return true;
  });
});
