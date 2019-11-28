# Практика по многопоточности I.
## Содержание
1. [Содержание](#содержание)
1. [Заданиие на счётчик](#задание-на-счётчик)
    1. [Настраиваемся](#настраиваемся)
    1. [Простой счётчик](#простой-счётчик)
    1. [Только чётные](#только-чётные)
    1. [Добавляем snapshot](#добавляем-snapshot)
    1. [Добавляем ещё один рабочий поток](#добавляем-ещё-один-рабочий-поток)
    1. [Добавляем мьютекс](#добавляем-мьютекс)

## Задание на счётчик
### Настраиваемся
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

2. Собрать и запустить можно одним из следующих способов:
    1. Из командной строки при помощи `gcc` (в директории с файлом `main.cpp`). <br/>
 `g++ main.cpp -pthread -g -Wall -Wextra -Werror -o main && ./main` 

    1. При помощи `cmake`. <br/>
 `cmake . && make && ./main`
 
    1. Можно открыть проект в CLion и запустить там.
 
 3. Для автоматической правки стиля кода будем использовать `clang-format`.
     1. Ставим <br/>
 `sudo apt-get install clang-format`
     1. Запускаем на одном файле `main.cpp`. <br/>
 `clang-format -i -style=file main.cpp`
     1. Чтобы запустить для всех файлов в директории `src`. <br/>
 `clang-format -i -style=file src/*`
  
 
 3. Чтобы искать гонки данных
     1. `valgrind --tool=helgrind ./main`
     1. `valgrind --tool=drd ./main`

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
2. Пересоберите программу и запустите, посмотрите, что выводится.
3. Запустите под `valgrind`.

### Только чётные
1. Измените программу так, чтобы выводились только чётные числа.
```c++
#include <assert.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

const int N = 500000000;
const int M = 10000;

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
        if (data % 2 == 0) {
            printf("data is %d (in progress)\n", data);
            assert(data % 2 == 0);
        }
    }
    assert(pthread_join(id, NULL) == 0);
    printf("data is %d\n", data);
    return 0;
}
```
2. Пересоберите программу и запустите, посмотрите, что выводится.
3. Запустите под `valgrind`.

### Добавляем snapshot
1. Прежде чем делать что-то с переменной `data` в цикле главного потока, сохраним её значение в локальную переменную.
```c++
#include <assert.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

const int N = 500000000;
const int M = 10000;

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
        int data_snapshot = data;
        if (data_snapshot % 2 == 0) {
            printf("data is %d (in progress)\n", data_snapshot);
            assert(data_snapshot % 2 == 0);
        }
    }
    assert(pthread_join(id, NULL) == 0);
    printf("data is %d\n", data);
    return 0;
}
```
2. Пересоберите программу и запустите, посмотрите, что выводится.
3. Запустите под `valgrind`.

### Добавляем ещё один рабочий поток
1. Создаём ещё один поток, который будет делать то же самое.
```c++
#include <assert.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

const int N = 500000000;
const int M = 10000;

int data;
void* worker(void*) {
    for (int i = 0; i < N; i++) {
        data++;
    }
    return NULL;
}

int main() {
    pthread_t id1, id2;
    assert(pthread_create(&id1, NULL, worker, NULL) == 0);
    assert(pthread_create(&id2, NULL, worker, NULL) == 0);
    for (int i = 0; i < M; i++) {
        int data_snapshot = data;
        if (data_snapshot % 2 == 0) {
            printf("data is %d (in progress)\n", data_snapshot);
            assert(data_snapshot % 2 == 0);
        }
    }
    assert(pthread_join(id1, NULL) == 0);
    assert(pthread_join(id2, NULL) == 0);
    printf("data is %d\n", data);
    return 0;
}
```
2. Пересоберите программу и запустите, посмотрите, что выводится.
3. Запустите под `valgrind`.

### Добавляем мьютекс
1. Избавимся от гонки добанных, добавив мьютекс.
```c++
#include <assert.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

const int N = 500000;
const int M = 10000;

int data;
pthread_mutex_t m;
void* worker(void*) {
    for (int i = 0; i < N; i++) {
        pthread_mutex_lock(&m);
        data++;
        pthread_mutex_unlock(&m);
    }
    return NULL;
}

int main() {
    pthread_t id1, id2;
    pthread_mutex_init(&m, NULL);
    assert(pthread_create(&id1, NULL, worker, NULL) == 0);
    assert(pthread_create(&id2, NULL, worker, NULL) == 0);
    for (int i = 0; i < M; i++) {
        int data_snapshot = data;
        if (data_snapshot % 2 == 0) {
            printf("data is %d (in progress)\n", data_snapshot);
            assert(data_snapshot % 2 == 0);
        }
    }
    assert(pthread_join(id1, NULL) == 0);
    assert(pthread_join(id2, NULL) == 0);
    pthread_mutex_destroy(&m);
    printf("data is %d\n", data);
    return 0;
}
```
2. Запускаем, видим, что всё тормозит.
3. Уменьшаем константы.
4. Запускаем.
5. Проверяем `valgrind`, что гонка данных пропала.

## Новое дз
Я должна рассказать про:
1. Что нужно сделать.
1. `CMakeLists.txt`, что там менять и что можно добавить.
1. Код обычной очереди, что и как.
1. Заглушку для кода многопоточной очереди.
1. Тесты.
