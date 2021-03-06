package com.codesquad.team10.todo.api;

import com.codesquad.team10.todo.entity.Log;
import com.codesquad.team10.todo.entity.User;
import com.codesquad.team10.todo.response.ResponseData;
import com.codesquad.team10.todo.service.LogService;
import com.codesquad.team10.todo.util.DateTimeFormatUtils;
import com.codesquad.team10.todo.util.ModelMapper;
import com.codesquad.team10.todo.dto.LogDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/board")
public class LogController {

    private static final Logger logger = LoggerFactory.getLogger(LogController.class);

    private LogService logService;

    public LogController(LogService logService) {
        this.logService = logService;
    }

    @GetMapping("/logs")
    public ResponseEntity<ResponseData> showLogs(HttpServletRequest request) {
        User loginUser = (User)request.getAttribute("user");
        List<LogDTO> logDTOs = logService.getLogs(loginUser.getBoard());
        return new ResponseEntity<>(new ResponseData(
                ResponseData.Status.SUCCESS,
                logDTOs),
                HttpStatus.OK);
    }

    @GetMapping("/log/{logId}")
    public ResponseEntity<ResponseData> showLog(@PathVariable int logId) {
        Log log = logService.getLogById(logId);
        return new ResponseEntity<>(new ResponseData(
                ResponseData.Status.SUCCESS,
                (LogDTO)ModelMapper.of(log)),
                HttpStatus.OK);
    }

    @GetMapping("/log/serverTime")
    public ResponseEntity<ResponseData> getServerTime() {
        return new ResponseEntity<>(new ResponseData(
                ResponseData.Status.SUCCESS,
                DateTimeFormatUtils.localDateTimeToString(LocalDateTime.now())),
                HttpStatus.OK);
    }
}
