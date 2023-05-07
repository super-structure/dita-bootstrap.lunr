let LUNR_DATA = null;
let PREVIEW_LOOKUP = null;
const scripts = document.getElementsByTagName("script");
const scriptPath = scripts[scripts.length - 1].src;
const BASE_URL = scriptPath.substr(0, scriptPath.lastIndexOf("/") + 1);

function jsonFetch(json, url) {
  return new Promise(function (resolve, reject) {
    if (json) {
      return resolve(json);
    }

    fetch(BASE_URL + url)
      .then((response) => {
        if (!response.ok) {
           reject(new Error(`HTTP error, status = ${response.status}`));
        }
        return response.json();
      })
      .then((data) => {
        return resolve(data);
      });
  });
}

// Parse search results into HTML
function parseLunrResults(results) {
  const html = [];
  for (let i = 0; i < results.length; i++) {
    const id = results[i]["ref"];
    const item = PREVIEW_LOOKUP[id];
    const title = item["t"];
    const preview = item["d"];
    const link = item["l"];
    const result =
      '<p><span class="h3"><a href="' +
      BASE_URL +
      link +
      '">' +
      title +
      "</a></span></p>" +
      preview;
    html.push(result);
  }
  if (html.length) {
    return html.join("");
  } else {
    return "<p>@@@lunr.no.search.results@@@</p>";
  }
}

function formatResults(results) {
  return `<article role="article">
    <div class="modal-header">
	        <h1>@@@lunr.search.results@@@</h1>
          <button type="button" class="btn-close" aria-label="Close" onclick="closeSearch(this);"></button>
      </div>
      <div class="modal-body">
    ${parseLunrResults(results)}
    </div>
    </article>`;
}

function escapeHtml(unsafe) {
  return unsafe
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}

function closeSearch(el) {
  const elements = document.getElementsByClassName("bs-main");
  elements[1].remove();
  elements[0].classList.remove("collapse");
  return false;
}

function search(el) {
  jsonFetch(LUNR_DATA, "search_index.json")
    .then((data) => {
      LUNR_DATA = data;
      return jsonFetch(PREVIEW_LOOKUP, "preview.json");
    })
    .then((data) => {
      PREVIEW_LOOKUP = data;
      const query = document.getElementById("search-input").value;
      const idx = lunr.Index.load(LUNR_DATA);
      // Write results to page
      const results = idx.search(query);
      const elements = document.getElementsByClassName("bs-main");

      if (elements.length < 2) {
        const resultHtml = `<main role="main" class="container bs-main">
          ${formatResults(results)}</main>`;

        elements[0].insertAdjacentHTML("afterend", resultHtml);
      } else {
        elements[1].innerHTML = formatResults(results);
      }

      elements[0].classList.add("collapse");
      window.scrollTo(0, 0);
      return false;
    })
    .catch((e) => {
      console.log(e);
    })
  return false;
}
