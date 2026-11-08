package by.famcs.usersapi

import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RestController

@RestController
class UserController(private val service: UserService) {

    // GET /users/42
    @GetMapping("/users/{id}")
    fun getUser(@PathVariable id: Long): ResponseEntity<User> =
        service.getUser(id)?.let { ResponseEntity.ok(it) } ?: ResponseEntity.notFound().build()
}
