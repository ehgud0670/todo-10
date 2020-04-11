function makeColumns({ sections }) {
    return sections.reduce((acc, column) => {
        acc +=
            `<div class="todo-columns content-wrap" data-type="column" id="column-${column.id}" data-column-id=${column.id} tabindex="0">
            <div class="todo-title">
            <h2><span class="todo-count">${column.cards.length}</span> ${column.title}</h2>
            <div class="btn-wrap">
                <button class="btn btn-toggle toggle-form"><span class="material-icons">add</span></button>
                <button class="btn"><span class="material-icons">more_vert</span></button>
            </div>
            </div>
            <div class="todo-form content-wrap" data-type="form">
                <form action="">
                    <input type="text" class="todo-input" placeholder="enter a note">
                    <textarea name="" id="" class="todo-textarea" cols="30" rows="10" maxlength="500" placeholder="enter a note"></textarea>
                    <div class="btn-wrap">
                    <button type="submit" class="btn btn-add" disabled="true">add</button>
                    <button type="reset" class="btn btn-close">cancel</button>
                    </div>
                </form>
            </div>
            <div class="card-wrap">
            ${makeCards(column.cards)}
            </div>
        </div>`;
        return acc;
    }, '');
}

function makeCards(cards) {
    return cards.reduce((acc, card) => {
        acc += addCard(card.id, card.content);
        return acc;
    }, '');
}

function addCard(id, content) {
    return `<div class="card-item content-wrap" draggable="true" data-type="card" id="card-${id}" data-card-id="${id}" tabindex="0">
                <div class="card-contents">${content}</div>
                <p class="card-writer">added by <span>홍길동</span></p>
                <button class="btn btn-close">
                    <span class="material-icons">close</span>
                </button>
            </div>`;
}

export {
    makeColumns,
    addCard,
}