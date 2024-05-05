function toggleElements(groupId) {
    var groups = document.getElementsByClassName('hidden-group');
    for (var i = 0; i < groups.length; i++) {
        if (groups[i].id === groupId) {
            groups[i].classList.toggle('visible');
        } else {
            groups[i].classList.remove('visible');
        }
    }
}