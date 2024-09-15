document.addEventListener("turbo:load", function() {
    let account = document.querySelector("#account");

    account.addEventListener("click", function(event) {
        event.preventDefault();
        let menu = document.querySelector("#dropdown-menu");
        console.log("a7a");
        console.log(menu);
        menu.classList.toggle("active");
    });
});
