window.onload = function() {
  var more = document.getElementById('load-more');
  var itemList = document.getElementsByClassName('itemList')[0];
  more.addEventListener('click', function(e){
    e.preventDefault();

    var xhr = new XMLHttpRequest();
    xhr.onload = function (){
      if (xhr.readyState === xhr.DONE) {
        if (xhr.status === 200) {
          var newElement = new window.DOMParser().parseFromString(xhr.response, 'text/html');
          var newItems = newElement.getElementsByClassName('item');
          newItems.forEach(function(newItem){
            itemList.appendChild(newItem);
          })
        }
      }
    };
    xhr.open('GET', this.href, true);
    xhr.overrideMimeType('text/xml');
    xhr.send();
  });
};
