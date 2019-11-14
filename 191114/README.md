# Практика про git

## Это буду показывать я

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

18) Редактируем сообщение об ошибке, вместо "Add b to a.txt" вводим "Add bbbb to a.txt"

19) Коммит изменился. Смотрим `git log`

20) Мы хотим проверить, что у нас есть нужные изменения. Для этого 

```shell
git diff <commit-hash>
```

21) Вообще, по умолчанию, `git diff` показывает разницу между working directory и staged area. Давайте проверим.

```shell
echo cc > b.txt
git diff
```

22) Если мы добавим файл в staging area, то `git diff` ничего не выведет.

```shell
git add b.txt
git diff
```

23) Чтобы посмотреть разницу между staging area и репозиторием, есть ключ `--staged`

```shell
git diff --staged
```

24) Мы хотим теперь вернуть всё, как было. Для этого можно сделать 

```shell
git reset --hard HEAD
```

Тогда **все незакоммиченные изменения исчезнут** (поэтому не надо прибегать к этой команде часто:)

25) В целом, мы можем откатиться к какому угодно коммиту.

```shell
git log
git reset --hard <commit-hash>
git log
```

26) Теперь мы решили вернуться обратно.

```shell
git reflog
git reset HEAD@{1}
git log
git status
```

27) Мы вернули коммит, но у нас файл a.txt находится в состоянии modified. Чтобы вернуть его обратно к коммиту, можно сделать 

```shell
git checkout -- a.txt
```

28) Теперь хотим создать новую ветку, назовём её `hw1`.  Для этого либо

```shell
git branch hw1
git checkout hw1
```

либо

```shell
git checkout -b hw1
```

29) Смотрим, что у нас тут есть.

```shell
git status
git log
```

30) Создаём папочку `hw1`, переходим в неё.

```shell
mkdir hw1
cd hw1
```

31) Хотим писать код на питоне.

```shell
touch hello_world.py
notepad++ hello_world.py
git add hello_world.py
git commit -m "Print 'hello world'"
notepad++ hello_world.py
```

32) Тут нас отвлекли и сказали, что нам нужно исправить баг в master, делает `git stash` и переключаемся в master.

```shell
git stash
git checkout master
```

Меняем что-нибудь, коммитим изменения.

33) Переключаемся обратно в hw1, возвращаем нашу заначку.

```shell
git checkout hw1
git stash pop
```

## Это будете делать вы (вместе со мной)

1) Открываем [https://github.com/git-demo-practice/git-demo](https://github.com/git-demo-practice/git-demo). Я показываю, что там есть (например, .gitignore).

2) Делаем fork.

3) Клонируем ваш репозиторий себе на github (**не копипастить**).

```shell
git clone https://github.com/olgalupuleac/git-demo.git
```

4) Как взять оттуда изменения (показываю я).

```shell
git remote -v
git remote add upstream https://github.com/git-demo-practice/git-demo
git fetch upstream
git merge upstream/master
```

5) Создаём ветку `hw1`

```shell
git checkout -b hw1
```

6) По очереди реализуем функции в файле hw1/calculator.py, для каждой реализованной функции делаем коммит.

7) Отправляем всё на github.

```shell
git push -u origin hw1
```

8) Создаём pull request в исходный репозиторий.

9) Теперь пойдём выполнять второе дз. **Переключаемся на ветку master**.

```shell
git checkout master
```

10) Теперь переключаемся на новую ветку hw2.

```shell
git checkout -b hw2
```

11) Реализуем функцию внутри файла hw2/strings.py

12) Коммитим изменения. 

13) Отправляем изменения, создаём pull request.

```shell
git push -u origin hw2
```

14) Теперь допустим нам пришли замечания по первому дз, давайте править

```shell
git checkout hw1
```

15) Поправили, закоммитили, отправляем изменения.

```shell
git push
```

## ДЗ

1) Упражнения [https://pb-fall2019.yeputons.net/](https://pb-fall2019.yeputons.net/). Я показываю.

2) Чистая история.

3) Вопрос про дедлайны.