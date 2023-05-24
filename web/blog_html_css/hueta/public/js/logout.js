const logoutLink = document.querySelector('a[href="/login"]');

logoutLink.addEventListener('click', () => {
  localStorage.clear();
});