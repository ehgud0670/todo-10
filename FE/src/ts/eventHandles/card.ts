import { getEl, getParentEl, addClass, removeClass } from '../util/commonUtil';
import { ALERT_MESSAGE, COMMON_RULE, STATUS_KEY } from '../contants/constant';
import { URL } from '../contants/url';
import { httpRequest } from '../http/request';
import { ICardOption } from '../interface/todoInterface';

const option: ICardOption = {
    dragTarget: null,
    targetHeight: null,
    toTarget: null,
    toTargetWrap: null,
    prevColumn: null,
    currColumn: null,
}

async function deleteCard(target: HTMLElement) {
    if (!target.classList.contains('btn-close')) return;
    if (!confirm(ALERT_MESSAGE.DELETE_CARD)) return;
    const column: HTMLElement = getParentEl(target, '.todo-columns');
    const card: HTMLElement = getParentEl(target, '.card-item');
    const columnId = column.dataset.columnId;
    const cardId = card.dataset.cardId;
    const url = `${URL.DEV.HOST}/mock/section/${columnId}/card/${cardId}`
    const { status } = await httpRequest.delete(url)

    if (status !== STATUS_KEY.SUCCESS) return;
    column.querySelector('.todo-count').innerHTML--;
    card.remove();
}

function showEditModal({ target }) {
    const card: HTMLElement = getParentEl(target, '.card-item');
    if (!card) return;
    const content = card.querySelector('.card-contents').innerText;
    const modalContents = getEl('.modal-contents');
    modalContents.setAttribute('data-column-id', getParentEl(card, '.todo-columns').dataset.columnId);
    modalContents.setAttribute('data-card-id', card.dataset.cardId);
    modalContents.querySelector('.todo-textarea').value = content;
    addClass(this.todoView.todoModal, COMMON_RULE.ACTIVE_KEY);
}

function dragStartCard({ target }) {
    resetOption();
    if (target.dataset.type !== 'card') return;
    option.dragTarget = target;
    option.targetHeight = target.offsetHeight;
    option.prevColumn = getParentEl(option.dragTarget, '.todo-columns');
    addClass(option.dragTarget, COMMON_RULE.DRAG_KEY);
}

function dragoverCard(evt) {
    evt.preventDefault();
}

function dragenterCard(evt) {
    if (!option.dragTarget) return;
    option.toTarget = getParentEl(evt.toElement, '.card-item');
    option.toTargetWrap = getParentEl(evt.toElement, '.card-wrap');
    option.currColumn = getParentEl(evt.toElement, '.todo-columns');
    const cardHeightHalf = option.targetHeight / 2;
    if (option.toTarget && evt.offsetY > cardHeightHalf) option.toTarget.after(option.dragTarget);
    else if (option.toTarget && evt.offsetY <= cardHeightHalf) option.toTarget.before(option.dragTarget);
    else if (option.toTargetWrap) return;
    else if (option.currColumn) option.currColumn.querySelector('.card-wrap').appendChild(option.dragTarget);
}

function dragendCard({ target }) {
    if (!option.dragTarget) return;
    removeClass(option.dragTarget, COMMON_RULE.DRAG_KEY);
    if (!option.dragTarget || !option.currColumn) return;
    if (!target.classList.contains('card-wrap')) target = option.currColumn.querySelector('.card-wrap');
    option.prevColumn.querySelector('.todo-count').innerHTML--;
    option.currColumn.querySelector('.todo-count').innerHTML++;
}

function getDragedCardInfo() {
    let order = 0;
    const currColumnId = option.currColumn.dataset.columnId;
    const cardId = option.dragTarget.dataset.cardId;
    [...getParentEl(option.dragTarget, '.card-wrap').children].some(v => {
        order++;
        return option.dragTarget === v;
    });
    return { cardId, order, currColumnId };
}

function resetOption() {
    for (let key in option) {
        option[key] = null;
    }
}

export {
    deleteCard,
    showEditModal,
    dragStartCard,
    dragoverCard,
    dragenterCard,
    dragendCard,
}