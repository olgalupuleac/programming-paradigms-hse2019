# Практика по многопоточности I.
## Содержание
## Задание на счётчик
1. Скачайте файлы из этого репозитория. Можно только [main.cpp](src/main.cpp):

```c++
#include <assert.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

int data = 1234;

void* worker(void*) {
    printf("Hello from thread! data=%d\n", data);
    data += 10;
    return NULL;
}

int main() {
    pthread_t id;
    assert(pthread_create(&id, NULL, worker, &data) == 0);
    assert(pthread_join(id, NULL) == 0);
    printf("data is %d\n", data);
    return 0;
}
```
1. Запускать можно одним из следующих способов:
    1. Из командной строки при помощи `gcc` (в директории с файлом `main.cpp`).
```
g++ main.cpp -pthread -g -Wall -Wextra -Werror -o main
``` 
    1. При помощи `cmake` 
 ```
cmake .
make
```
