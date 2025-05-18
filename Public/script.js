window.onload = function() {
    const content = document.getElementById("content");

    setTimeout(() => {
        content.style.opacity = "1";
    }, 50);

    const links = document.querySelectorAll(".link");
    links.forEach(link => {
        link.addEventListener("click", function(event) {
            event.preventDefault();
            const url = link.getAttribute("href");

            content.style.opacity = "0";

            setTimeout(() => {
                window.location.href = url;
            }, 100);
        });
    });
};
