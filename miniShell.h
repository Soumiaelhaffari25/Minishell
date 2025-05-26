#ifndef SE_H
#define SE_H

// Macros de feature test nécessaires AVANT les includes
#define _GNU_SOURCE      // Pour getline
#define _DEFAULT_SOURCE  // Pour usleep
#define _POSIX_C_SOURCE 200809L  // Alternative pour getline

#include <pwd.h>        // pour struct passwd et getpwuid
#include <unistd.h>     // pour getuid et usleep
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <sys/wait.h>
#include <sysexits.h>

//Codes de couleurs ANSI utilisés pour formater le texte dans le terminal
#define RED "\033[1;31m"
#define GREEN "\033[1;32m"
#define YELLOW "\033[1;33m"
#define BLUE "\033[1;34m"
#define CYAN "\033[1;36m"
#define NC "\033[0m"

#define ERROR(msg) fprintf(stderr, RED msg NC "\n")
#define DL "\t\n\v\f\r "

//Le statut du codes pour les opérations shell
enum{
    OK,        /* Operation succeeded */
    ERROR      /* Operation failed */
};

/**
 * Structure représentant une commande interne (built-in).
 * @builtin_name Nom de la commande intégrée (ex: "cd", "exit", etc.)
 * @foo Pointeur vers la fonction qui implémente la commande
 */
typedef struct s_builtin{
    const char *builtin_name;
    int (*foo)(char **av);
} t_builtin;

/**
 * Built-in command function prototypes
 * Each returns 0 on success, non-zero on failure
 */
int se_echo(char **args);  /* Echo command implementation */
int se_env(char **args);   /* Environment variables display */
int se_exit(char **args);  /* Shell exit command */

//Animation et banner
void exitLoading();
void printbanner();

/**
 * Wrappers pour les appels système avec gestion des erreurs
 * Chaque wrapper vérifie les erreurs et les traite de manière appropriée
 */
int Chdir(const char *path);
pid_t Fork(void);
void Execvp(const char *file, char *const argv[]);
pid_t Wait(int *status);
pid_t Waitpid(pid_t pid, int *status, int options);
void *Malloc(size_t size);
void *Realloc(void *ptr, size_t size);
char *Getcwd(char *buf, size_t size);
void Getline(char **lineptr, size_t *n, FILE *stream);

#endif