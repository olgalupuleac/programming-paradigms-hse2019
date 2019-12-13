import pytest_mock
from calculator_user_handler import CalculatorUserHandler


def test_addition(mocker: pytest_mock.MockFixture) -> None:
    send_message = mocker.stub(name='send_message_stub')
    CalculatorUserHandler(send_message).handle_message('2 + 3')
    assert send_message.call_args_list == [mocker.call('5')]


def test_multiple_operations(mocker: pytest_mock.MockFixture) -> None:
    send_message = mocker.stub(name='send_message_stub')
    bot = CalculatorUserHandler(send_message)
    bot.handle_message('2 * 3')
    bot.handle_message('3 / 2')
    bot.handle_message('3 - 4')
    assert send_message.call_args_list == [
        mocker.call('6'),
        mocker.call('1'),
        mocker.call('-1')
    ]