#include <assert.h>
#include <pthread.h>
#include <iostream>

pthread_mutex_t mutex;
pthread_cond_t cond_flag_changed;
int flag;

void *consumer(void *) {
    bool is_finished = false;
    while (!is_finished) {
        pthread_mutex_lock(&mutex);
        while (flag == 0) {
            pthread_cond_wait(&cond_flag_changed, &mutex);
        }
        std::cout << "Flag changed to " << flag << std::endl;
        if (flag == -1) {
            is_finished = true;
        }
        flag = 0;
        pthread_mutex_unlock(&mutex);
    }
    return nullptr;
}

int main() {
    pthread_mutex_init(&mutex, nullptr);
    pthread_cond_init(&cond_flag_changed, nullptr);
    pthread_t id;
    assert(pthread_create(&id, nullptr, consumer, nullptr) == 0);
    while (true) {
        int new_flag;
        std::cin >> new_flag;
        pthread_mutex_lock(&mutex);
        flag = new_flag;
        pthread_cond_signal(&cond_flag_changed);
        pthread_mutex_unlock(&mutex);
        if (new_flag == -1) {
            break;
        }
    }
    assert(pthread_join(id, nullptr) == 0);
    pthread_cond_destroy(&cond_flag_changed);
    pthread_mutex_destroy(&mutex);
    return 0;
}