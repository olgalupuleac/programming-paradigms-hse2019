# Практика по многопоточности I.
## Содержание
## Задание на счётчик
### Настраиваемся...
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

2. Запускать можно одним из следующих способов:
    1. Из командной строки при помощи `gcc` (в директории с файлом `main.cpp`). <br/>
 `g++ main.cpp -pthread -g -Wall -Wextra -Werror -o main`

    1. При помощи `cmake`. <br/>
 `cmake . & make`
 
    1. Можно открыть проект в CLion и запустить там.

### Простой счётчик

1. Добавьте в функцию `worker` увеличение счётчика `data` в цикле `N` раз, а в `main` -- печать переменной `data` `M` раз.
```c++
#include <assert.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

const int N = 500000000;
const int M = 1000;

int data;
void* worker(void*) {
    for (int i = 0; i < N; i++) {
        data++;
    }
    return NULL;
}

int main() {
    pthread_t id;
    assert(pthread_create(&id, NULL, worker, NULL) == 0);
    for (int i = 0; i < M; i++) {
        printf("data is %d (in progress)\n", data);
    }
    assert(pthread_join(id, NULL) == 0);
    printf("data is %d\n", data);
    return 0;
}
```
2. Запустите программу, посмотрите, что выводится.
