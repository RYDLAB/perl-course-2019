function textAreaAdjust(element) {
    element.style.height = "1px";
    element.style.height = (25 + element.scrollHeight) + "px";
}

function addCode(content) {
    var wrapper = document.createElement('div');
    wrapper.className = 'snippet-add-form__part';
    var codeElement = createCodeElement(content);
    wrapper.appendChild(codeElement);
    wrapper.appendChild(createDeleteIcon());
    document.querySelector('.snippet-add-form__parts').appendChild(wrapper);
    textAreaAdjust(codeElement.querySelector('textarea'));
    codeElement.scrollIntoView();
    codeElement.querySelector('textarea').focus();
}

function createDeleteIcon() {
    var img = document.createElement('img');
    img.className = 'square-32 snippet-add-form__delete';
    img.alt = 'delete';
    img.src = '/delete-24px.svg';
    img.addEventListener('click', e => e.target.parentNode.parentNode.removeChild(e.target.parentNode));
    return img;
}

function createCodeElement(content) {
    var label = document.createElement('label');
    label.appendChild(createCodeTextarea(content));

    return label;
}

function createCodeTextarea(content) {
    var textarea = document.createElement('textarea');
    if (content) {
        textarea.value = content;
    }

    textarea.addEventListener('keyup', e => textAreaAdjust(e.currentTarget));
    textarea.addEventListener('keydown', e => textAreaAdjust(e.currentTarget));

    textarea.setAttribute('required', 'true');

    return textarea;
}

function addUrl() {
    var wrapper = document.createElement('div');
    wrapper.className = 'snippet-add-form__url-part snippet-add-form__part';
    wrapper.innerHTML = '\n' +
        '<label class=" snippet-add-form__url-part-label">\n' +
        '    <img src="/language-24px.svg" alt="URL" class="square-32">\n' +
        '    <input type="text" required class="snippet-add-form__url-part-input"/>\n' +
        '</label>\n' +
        '<img src="/delete-24px.svg" alt="delete" class="square-32 snippet-add-form__delete">';
    document.querySelector('.snippet-add-form__parts').appendChild(wrapper);
    wrapper.querySelector('.snippet-add-form__delete').addEventListener('click',
        e => e.target.parentNode.parentNode.removeChild(e.target.parentNode));
    wrapper.scrollIntoView();
    wrapper.querySelector('input').focus();
}

function addCodeFromFile() {
    document.getElementById('uploadInput').click();
}

function getFile(event) {
    const input = event.target;
    if ('files' in input && input.files.length > 0) {
        placeFileContent(input.files[0])
    }
}

function placeFileContent(file) {
    readFileContent(file)
        .then(content => addCode(content))
        .catch(error => console.log(error))
}

function readFileContent(file) {
    const reader = new FileReader();
    return new Promise((resolve, reject) => {
        reader.onload = event => resolve(event.target.result);
        reader.onerror = error => reject(error);
        reader.readAsText(file)
    })
}

function extractParts() {
    var parts = [];
    var partsNodes = document.getElementsByClassName("snippet-add-form__part");
    for (var i = 0; i < partsNodes.length; i++) {
        var part = partsNodes.item(i);
        if (part.classList.contains('snippet-add-form__url-part')) {
            parts.push({url: part.querySelector('input').value});
        } else {
            parts.push({value: part.querySelector('textarea').value})
        }
    }
    return parts;
}

function submitSnippet(event) {
    event.preventDefault();
    fetch('/api/snippets/add', {
        method: 'POST',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            parts: extractParts(),
            private: document.getElementById('isPrivate').checked ? "1" : "0"
        })
    })
        .then(r => {
            if (!r.ok) {
                throw new Error(r.statusText);
            }

            return r;
        })
        .then(r => r.json())
        .then(j => {
            if (j.url) {
                window.location.href = j.url;
            }
        })
        .catch(e => console.error(e));
    return false;
}

document.getElementById('uploadInput').addEventListener('change', getFile);
document.querySelector('.snippet-add-form').addEventListener('submit', submitSnippet);
