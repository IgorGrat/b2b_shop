package enginee.processing.query;

public class Client_Query {
    private static String url="127.0.0.1"; // m3c.dako.ua;
    private static int port=20101;
    private String form;
    private String method;
    private Object param;

    public String getUrl() {
        return url;
    }

    public int getPort() {
        return port;
    }

    public String getForm() {
        return form;
    }

    public String getMethod() {
        return method;
    }

    public Object getParam() {
        return param;
    }

    public Client_Query(String form, String method, Object param) {
        this.form = form;
        this.method = method;
        this.param = param;
    }
}
