import { httpRequest } from '../utils/httpRequestUtil';
import { URL } from '../contants/url';
import TodoView from './todoView';
import TodoEventManager from './todoEventManager';

class TodoController {
    private todoView: TodoView;
    private todoEventManager: TodoEventManager;

    constructor(todoView: TodoView, todoEventManager: TodoEventManager) {
        this.todoView = todoView;
        this.todoEventManager = todoEventManager;
    }

    runTodoApp(): void {
        this.todoEventManager.initTodoHeaderEvent();

        const url = `${URL.MOCKUP.BASE}/mock/login`;
        httpRequest.login(url).then(todoData => {
            this.todoView.renderTodoApp(todoData);
            this.todoView.renderTodoModal();
            this.todoEventManager.initTodoAppEvent();
            this.todoEventManager.initTodoModalEvent();
        });

        this.todoView.renderTodoMenu();
        this.todoEventManager.initTodoMenuEvent();
    }
}

export default TodoController;