package by.famcs.usersapi

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.context.properties.ConfigurationPropertiesScan
import org.springframework.boot.runApplication

@SpringBootApplication
@ConfigurationPropertiesScan
class UsersApiApplication

fun main(args: Array<String>) {
    runApplication<UsersApiApplication>(*args)
}
