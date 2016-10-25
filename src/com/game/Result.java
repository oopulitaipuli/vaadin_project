package com.game;

import com.user.User;
import com.word.WordList;

import java.util.Date;
import java.util.logging.Logger;

/**
 * Object represents a result from a single (completed) run
 * Created by samlinz on 17.10.2016.
 */
public class Result {

    // result data
    private Date date;
    // referenced list
    private WordList list;
    // time in seconds
    private int time;
    // max score
    private int maxScore;
    // run score
    private int score;
    // reference to the user who made the result
    private User user;

    /* Getters and setters */

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public WordList getList() {
        return list;
    }

    public void setList(WordList list) {
        this.list = list;
    }

    public int getTime() {
        return time;
    }

    public void setTime(int time) {
        this.time = time;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public int getMaxScore() {
        return maxScore;
    }

    public void setMaxScore(int maxScore) {
        this.maxScore = maxScore;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    // logger
    private static Logger LOG;

    static {
        LOG = Logger.getLogger(Result.class.getName());
    }
}