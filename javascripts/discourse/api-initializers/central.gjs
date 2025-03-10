import { apiInitializer } from "discourse/lib/api";

export default apiInitializer("1.0", (api) => {
  // Category Icon Styling
  const categories = settings.category_icons;

  if (categories) {
    const css = categories.map((category) => {
      const id = category.id[0];
      const emoji = category.emoji;
      return `.badge-category__wrapper .badge-category[data-category-id="${id}"]:before { content: "${emoji}"; }`;
    });

    const styleElement = document.createElement("style");
    styleElement.type = "text/css";
    styleElement.appendChild(document.createTextNode(css.join("\n")));
    document.head.appendChild(styleElement);
  }

  // Unlock Theme Editing in Admin Panel
  api.onPageChange(() => {
    if (document.querySelector(".admin-content")) {
      let messageElement = document.querySelector(".source");
      if (messageElement) {
        messageElement.innerHTML = "This theme is now fully editable.";
      }

      let updateElement = document.querySelector(".check-for-updates");
      if (updateElement) {
        updateElement.style.display = "none";
      }
    }
  });
});
