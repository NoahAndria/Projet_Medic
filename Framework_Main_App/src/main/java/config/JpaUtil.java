package config;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class JpaUtil {

    private static final AnnotationConfigApplicationContext context =
        new AnnotationConfigApplicationContext(JpaConfig.class);

    public static <T> T getRepository(Class<T> repositoryClass) {
        return context.getBean(repositoryClass);
    }

    public static void close() {
        context.close();
    }
}