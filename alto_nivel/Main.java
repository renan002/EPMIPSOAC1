package alto_nivel;

public class Main {

    public static void main(String[] args) {
        String a = args[0];
        String b = args[1];

        System.out.printf("a: %s\n", a);
        System.out.printf("b: %s\n", b);

        int init = a.length()-b.length();
        if (init<0) {
            System.out.println("false");
            return;
        }
        int end = a.length();

        String c = a.substring(init, end);

        System.out.printf("c: %s\n", c);

        System.out.printf("c.equals(b): %b\n", c.equals(b));
    }
}
