document.addEventListener("DOMContentLoaded", function () {
    const slider = document.querySelector(".new-arrival-slider");

    let isDown = false;
    let startX;
    let scrollLeft;

    slider.addEventListener("mousedown", (e) => {
        isDown = true;
        slider.classList.add("active");
        startX = e.pageX - slider.offsetLeft;
        scrollLeft = slider.scrollLeft;
        console.log("mousedown", startX, scrollLeft);
    });

    slider.addEventListener("mouseup", () => {
        isDown = false;
        slider.classList.remove("active");
        console.log("mouseup");
    });

    slider.addEventListener("mousemove", (e) => {
        if (!isDown) return;
        e.preventDefault();
        const x = e.pageX - slider.offsetLeft;
        const walk = (x - startX); // Điều chỉnh tốc độ cuộn
        slider.scrollLeft = scrollLeft - walk;
        console.log("mousemove", x, walk);
    });
});