console.log("Hola");

window.onload = function() {
    // Efecto de aparición al cargar la página
    const content = document.getElementById("content");

    // Usar setTimeout para cambiar directamente la opacidad
    setTimeout(() => {
        content.style.opacity = "1";
    }, 50); // Esperar un pequeño tiempo para asegurar el repintado

    // Añadir el efecto de desvanecimiento al hacer clic en los enlaces
    const links = document.querySelectorAll(".link");
    links.forEach(link => {
        link.addEventListener("click", function(event) {
            event.preventDefault();
            const url = link.getAttribute("href");

            // Añadir el efecto de desvanecimiento
            content.style.opacity = "0";

            // Esperar el tiempo de la animación y luego navegar
            setTimeout(() => {
                window.location.href = url;
            }, 100); // Duración de la animación en milisegundos
        });
    });
};
