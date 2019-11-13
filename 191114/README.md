# Практика про git

1) Создаём где-нибудь папку, с которой будем эксперементировать и переходим в неё.

```shell
mkdir git_demo
cd git_demo
```



2) Проверяем настройки git.

```shell
git config --global user.name
git config --global user.email
```

Если ничего не вывелось, то нужно их задать. Например, в моём случае это выглядело бы так (**не надо копипастить, впишите сюда своё имя и почту**:)

```shell
git config --global user.name "Olga Lupuleac"
git config --global user.email "olga.lupuleac@gmail.com"
```

Также можно проверить, какой редактор у вас стоит по умолчанию.

```shell
git config --global core.editor
```

Я настроила себе notepad++, и поэтому он каждый раз долго грузится:(

3) Создаём пустой репозиторий.

```shell
git init
```

4) Создаём в папке git_demo файл a.txt, пишет туда строчку "aaaa", в git bash или на Линуксе это делается так

```shell
touch a.txt
echo aaaa > a.txt
```

В стандартной виндовой консоли 

```powershell
type nul > a.txt
echo aaaa > a.txt
```



5) Проверяем состояние нашего репозитория

```sh
git status
```

6) Добавляем файл a.txt в staging area.

```shell
git add a.txt
```

7) Снова `git status`.

8) Создаём первый коммит

```shell
git commit
```

Сейчас откроется редактор и надо будет ввести сообщение к коммиту.

Чтобы это было быстрее, можно ввести его сразу с ключом `-m`

```shell
git commit -m "Add a.txt"
```

9) Теперь добавим какую-нибудь строчку к файлу a.txt.

```shell
echo b >> a.txt
git status
```

10) Добавим этот файл в stage area.

```shell
git add a.txt
```

11) Создадим ещё один файл и добавим его также в git.

```shell
touch b.txt
echo "one line" > b.txt
```

12) Добавляем его в staging area.

```shell
git add b.txt
```

13) Хотим сделать коммит. Но так как мы хотим, чтобы коммит был атомарным, то мы хотим добавить только один файл. Для этого нам надо убрать a.txt из staging area.

```shell
git reset HEAD a.txt
```

14) Коммитим файл b.txt

```shell
git commit -m "Add b.txt"
```

15) Добавляем и коммитим файл a.txt

```shell
git add a.txt
git commit -m "Add b to a.txt"
```

16) Посмотрим историю коммитов

```shell
git log
```

17) Тут мы поняли, что хотели добавить в a.txt не "b", а "bbbb". Упс. Нам надо как-то отредактировать последний коммит.

```shell
notepad a.txt #исправили файл (только для Винды)
git add a.txt
git commit --amend
```

