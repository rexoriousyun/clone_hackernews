window.onload = function() {
  var more = document.getElementById('load-more');
  var itemList = document.getElementsByClassName('itemList')[0];
  more.addEventListener('click', function(e){
    e.preventDefault();

    var xhr = new XMLHttpRequest();
    xhr.onload = function (){
      if (xhr.readyState === xhr.DONE) {
        if (xhr.status === 200) {
          var newElement = (new DOMParser()).parseFromString(xhr.response, 'text/xml');
          console.log(xhr.response, newElement)
          var newItems = newElement.getElementsByClassName('item');
          for (i=0; i < newItems.length; i++) {
            itemList.appendChild(newItems[i]);
          };
        }
      }
    };
    xhr.open('GET', this.href, true);
    xhr.overrideMimeType('text/xml');
    xhr.send();
  });
};
