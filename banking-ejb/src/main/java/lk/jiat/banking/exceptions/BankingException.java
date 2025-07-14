package lk.jiat.banking.exceptions;

public class BankingException extends RuntimeException {

    public BankingException() {
        super();
    }

    public BankingException(String message) {
        super(message);
    }

    public BankingException(String message, Throwable cause) {
        super(message, cause);
    }

    public BankingException(Throwable cause) {
        super(cause);
    }

    protected BankingException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}