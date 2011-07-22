require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "order_received" do
    mail = Notifier.order_received(orders(:one))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["dave@example.org"], mail.to
    #assert_equal ["zoller.lmx@gmail.com"], mail.from
  end

  test "order_shipped" do
    mail = Notifier.order_shipped(orders(:one))
    assert_equal "Your Order Is Shipped", mail.subject
    assert_equal ["dave@example.org"], mail.to
    #assert_equal ["zoller.lmx@gmail.com"], mail.from
  end

end
