import { API_URL } from '../contants/url';
import { getParentEl, toggleClass } from '../util/commonUtil';
import { httpRequest } from '../http/request';

function closeForm(target) {
    return toggleClass({
        target: target,
        containsClassName: 'btn-close',
        closestClass: '.todo-form',
        toggleClassName: 'active',
    });
}

function submitForm(evt, callback) {
    evt.preventDefault();
    const column = getParentEl(evt.target, '.todo-columns');
    const columnId = column.dataset.columnId;
    const data = evt.target.querySelector('textarea').value;
    const url = `${API_URL}/mock/section/${columnId}/card`;
    httpRequest.post(url, { content: data }).then((data) => callback(evt, data));
}

export { closeForm, submitForm };
