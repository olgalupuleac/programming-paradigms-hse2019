#include <assert.h>
#include <pthread.h>
#include <iostream>

pthread_mutex_t mutex;
pthread_cond_t cond_flag_changed;
int flag;

void *consumer(void *) {
    bool is_finished = false;
    while (!is_finished) {
        while (flag == 0) {
        }
        std::cout << "Flag changed to " << flag << std::endl;
        if (flag == -1) {
            is_finished = true;
        }
        flag = 0;
    }
    return NULL;
}

int main() {
    pthread_mutex_init(&mutex, NULL);
    pthread_cond_init(&cond_flag_changed, NULL);
    pthread_t id;
    assert(pthread_create(&id, NULL, consumer, NULL) == 0);
    while (true) {
        int new_flag;
        std::cin >> new_flag;
        if (new_flag == 0) {
            continue;
        }
        flag = new_flag;
        if (new_flag == -1) {
            break;
        }
    }
    assert(pthread_join(id, NULL) == 0);
    pthread_mutex_destroy(&mutex);
    pthread_cond_destroy(&cond_flag_changed);
    return 0;
}