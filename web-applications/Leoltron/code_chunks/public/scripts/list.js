function elementInViewport(el) {
    var top = el.offsetTop;
    var left = el.offsetLeft;
    var width = el.offsetWidth;
    var height = el.offsetHeight;

    while (el.offsetParent) {
        el = el.offsetParent;
        top += el.offsetTop;
        left += el.offsetLeft;
    }

    return (
        top >= window.pageYOffset &&
        left >= window.pageXOffset &&
        (top + height) <= (window.pageYOffset + window.innerHeight) &&
        (left + width) <= (window.pageXOffset + window.innerWidth)
    );
}

function createSnippetNode(snippet) {
    var root = document.createElement('article');
    root.className = "snippet_preview";

    var pre = document.createElement('pre');
    var code = document.createElement('code');
    code.appendChild(document.createTextNode(snippet["text_short"]));
    pre.appendChild(code);
    root.appendChild(pre);
    hljs.highlightBlock(pre);
    hljs.lineNumbersBlock(pre);

    var controls = document.createElement('div');
    controls.className = "controls";

    var buttons = document.createElement('div');
    buttons.className = "button_row";

    var showFull = document.createElement('a');
    showFull.className = "button button_primary";
    showFull.href = "/" + snippet['url'];
    showFull.innerHTML = 'Show full';
    buttons.appendChild(showFull);

    var raw = document.createElement('a');
    raw.className = "button button_secondary";
    raw.href = "/" + snippet['url'] + '/raw';
    raw.innerHTML = 'Raw';
    buttons.appendChild(raw);

    controls.appendChild(buttons);

    var size = document.createElement('div');
    size.className = "controls__size";
    size.innerHTML = "" + snippet['total_length'] + " characters";
    controls.appendChild(size);

    var date = document.createElement('div');
    date.className = "controls__creationDate";
    date.innerHTML = "" + snippet['creation_date'] + " characters";
    controls.appendChild(date);

    root.appendChild(controls);

    return root;
}

function loadMorePages() {
    var loading = false;
    var loadedAll = false;
    return function () {
        if (loading || loadedAll) {
            return;
        }
        var lastSnippet = document.querySelector(".snippet_preview:last-child");
        if (elementInViewport(lastSnippet)) {
            loading = true;
            document.querySelector('.loadingWrapper').classList.remove('hide');
            var offset = document.querySelectorAll(".snippet_preview").length;
            fetch('/api/snippets?skip=' + offset + '&take=10')
                .then(r => {
                    loading = false;
                    document.querySelector('.loadingWrapper').classList.add('hide');
                    return r;
                })
                .then(response => response.json())
                .then(snippets => {
                    if(snippets.length === 0){
                        loadedAll = true;
                    }
                    var snippet_root = document.querySelector('.article_list');
                    snippets.forEach(s => snippet_root.appendChild(createSnippetNode(s)));
                });
        }
    }
}


window.addEventListener('scroll', loadMorePages());
