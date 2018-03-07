package io.github.zeyomir.mutual_ssl_sample;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Greeter {

  private static final String template = "Hello, %s!";

  @RequestMapping("/greeting")
  public String greet(
      @RequestParam(value = "name", required = false, defaultValue = "World!") String name) {
    return String.format(template, name);
  }

}
