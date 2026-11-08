package by.famcs.usersapi

import java.time.LocalDate
import java.time.OffsetDateTime

// одна строка таблицы users
data class User(
    val id: Long,
    val username: String,
    val email: String,
    val firstName: String,
    val lastName: String,
    val city: String,
    val birthDate: LocalDate,
    val createdAt: OffsetDateTime,
    val bio: String,
)
