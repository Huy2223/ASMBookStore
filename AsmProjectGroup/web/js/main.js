document.addEventListener("DOMContentLoaded", function () {
    var slider = document.querySelector(".slider");
    var sliderContainer = document.querySelector(".slider-container");
    var isDown = false;
    var startX;
    var scrollLeft;

    if (!slider || !sliderContainer) {
        console.error("Lỗi: Không tìm thấy slider hoặc slider-container.");
        return;
    }

    // Khi bắt đầu kéo
    sliderContainer.addEventListener("mousedown", function (e) {
        isDown = true;
        startX = e.pageX - sliderContainer.offsetLeft;
        scrollLeft = sliderContainer.scrollLeft;
    });

    // Khi kéo chuột
    sliderContainer.addEventListener("mousemove", function (e) {
        if (!isDown) return;
        e.preventDefault();
        var x = e.pageX - sliderContainer.offsetLeft;
        var walk = (x - startX) * 2; // Tăng tốc độ kéo
        sliderContainer.scrollLeft = scrollLeft - walk;
    });

    // Khi thả chuột
    sliderContainer.addEventListener("mouseup", function () {
        isDown = false;
    });

    // Khi chuột rời khỏi khu vực kéo
    sliderContainer.addEventListener("mouseleave", function () {
        isDown = false;
    });
});
