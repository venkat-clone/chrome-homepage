

let value, isEnabled;
console.log('from background.js')
return
value = 'chrome-extension://'+chrome.runtime.id+'/index.html';
isEnabled = true;
chrome.tabs.onCreated.addListener(function callback() {
    chrome.tabs.query({ active: true, lastFocusedWindow: true }, async (tabs) => {
        let url = tabs[0].url;
        let pendingUrl = tabs[0].pendingUrl;
        if (
            url == "" && //If a link is opened in chrome from another application, the script shouldn't fire
            pendingUrl == "chrome://newtab/" &&
            isEnabled &&
            value != '' && //it shouldn't fire if the input value is empty either
            !url.includes("file:///") && //script shouldn't fire if the browser is opening a local file
            !url.substring(0, 11).includes("C:/") &&
            !url.substring(0, 11).includes("D:/") &&
            !url.substring(0, 11).includes("E:/")
        ) {
            await chrome.tabs.update(tabs[0].id, { url: value });
            
        }
    });
});