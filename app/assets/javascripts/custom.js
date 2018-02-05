window.onload = function() {
  var more = document.getElementById('load-more');
  var itemList = document.getElementsByClassName('itemList')[0];
  var newItem = [];
  more.addEventListener('click', function(e){
    e.preventDefault();

    var xhr = new XMLHttpRequest();
    xhr.open('GET', this.href);
    xhr.responseType='text';
    xhr.overrideMimeType('text/xml');

    xhr.onload = function (){
      if (xhr.readyState === xhr.DONE) {
        if (xhr.status === 200) {
          var nodeCollection = new DOMParser().parseFromString(xhr.response, "text/html");
          var itemCollection = nodeCollection.getElementsByClassName('item');
          for (var item of itemCollection) {
            newItem.push(item);
          }
        }
      }
      ;[].forEach.call(newItem, function(el, i) {
        itemList.appendChild(el);
      })
    };
    xhr.send();
  });
};
