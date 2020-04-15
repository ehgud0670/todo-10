import { COMMON_RULE } from '../../contants/constant';
import { addClass, removeClass, hasClass } from '../../utils/commonUtil';

function showMenu() {
    addClass(this.todoView.todoMenu, COMMON_RULE.ACTIVE_KEY);
}

function closeMenu({ target }) {
    if (!hasClass(target, 'btn-close')) return;
    removeClass(this.todoView.todoMenu, COMMON_RULE.ACTIVE_KEY);
}

export {
    showMenu,
    closeMenu,
}