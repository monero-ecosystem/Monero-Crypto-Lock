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

chrome.runtime.sendMessage({
  from:    'content',
  subject: 'showPageAction'
});

chrome.runtime.onMessage.addListener(function (msg, sender, response) {
  let challengeDiv = document.getElementsByClassName("MoneroChallenge"),
    sigInput = document.getElementsByClassName("MoneroSignature"),
    address = document.getElementsByClassName("MoneroAddress"),
    submitButton = document.getElementsByClassName("MoneroSubmit");

  if (msg.from === 'popup'){
    if (msg.subject === 'DOMInfo') {
      // Collect the necessary data
      // (For your specific requirements `document.querySelectorAll(...)`
      //  should be equivalent to jquery's `$(...)`)
      var domInfo = {
        challenge: null,
        signature: null,
        address: null,
        submitButton: null
      }
      domInfo.challenge = (challengeDiv && challengeDiv[0]) ? challengeDiv[0].innerText : null;
      domInfo.signature = (sigInput && sigInput[0]) ? sigInput[0] : null;
      domInfo.address = (address && address[0]) ? address[0] : null;
      domInfo.submitButton = (submitButton && submitButton[0]) ? submitButton[0] : null;
      // Directly respond to the sender (popup),
      // through the specified callback */
      response(domInfo);
    } else if(msg.subject === 'Signed'){
        sigInput[0].value = msg.signature;
        address[0].value = msg.address;
        if (msg.doSubmit && submitButton){
            submitButton[0].click();
        }
    }
  }
});
