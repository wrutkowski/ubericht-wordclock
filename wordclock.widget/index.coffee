#
# Word Clock widget for Übersicht
# Wojciech Rutkowski (http://wojciech-rutkowski.com/)
# Raphael Hanneken (behoernchen.github.io) code used from Time Words widget
#

# Get the current hour as word.
command: ""

# Lower the frequency for more accuracy.
refreshFrequency: (1000 * 10) # (1000 * n) seconds


render: (o) -> """
  <div id="content">
    <span id="it">IT</span>R<span id="is">IS</span>C<span id="ten">TEN</span><span id="half">HALF</span><br>
    <span id="quarter">QUARTER</span><span id="twenty">TWENTY</span><br>
    <span id="five">FIVE</span>C<span id="minutes">MINUTES</span>H<br>
    <span id="past">PAST</span><span id="to">TO</span>E<span id="h_one">ONE</span><span id="h_two">TWO</span><br>
    <span id="h_three">THREE</span><span id="h_four">FOUR</span><span id="h_five">FIVE</span><br>
    <span id="h_six">SIX</span><span id="h_seven">SEVEN</span><span id="h_eight">EIGHT</span><br>
    <span id="h_nine">NINE</span><span id="h_ten">TEN</span><span id="h_eleven">ELEVEN</span><br>
    <span id="h_twelve">TWELVE</span>L<span id="oclock">OCLOCK</span>
  </div>
"""


update: (output, dom) ->
  hours = [null, "one", "two", "three", "four", "five", "six", "seven",
    "eight", "nine", "ten", "eleven", "twelve"]

  date   = new Date()
  minute = date.getMinutes()
  hour   = date.getHours()

  $(dom).find(".active").removeClass("active")

  $(dom).find("#it").addClass("active")
  $(dom).find("#is").addClass("active")

  if minute <= 2 || minute >= 58
    $(dom).find("#oclock").addClass("active")
  else if minute >= 3 && minute <= 7 || minute >= 53 && minute <= 57
    $(dom).find("#five").addClass("active")
    $(dom).find("#minutes").addClass("active")
  else if minute >= 8 && minute <= 12 || minute >= 48 && minute <= 52
    $(dom).find("#ten").addClass("active")
    $(dom).find("#minutes").addClass("active")
  else if minute >= 13 && minute <= 17 || minute >= 43 && minute <= 47
    $(dom).find("#quarter").addClass("active")
  else if minute >= 18 && minute <= 22 || minute >= 38 && minute <= 42
    $(dom).find("#twenty").addClass("active")
    $(dom).find("#minutes").addClass("active")
  else if minute >= 23 && minute <= 27 || minute >= 33 && minute <= 37
    $(dom).find("#twenty").addClass("active")
    $(dom).find("#five").addClass("active")
    $(dom).find("#minutes").addClass("active")
  else if minute >= 28 && minute <= 32
    $(dom).find("#half").addClass("active")

  if minute >= 3 && minute <= 32
    $(dom).find("#past").addClass("active")
  else if minute >= 33 && minute <= 57
    $(dom).find("#to").addClass("active")

  if minute >= 33
    hour++

  hour = hour % 12
  hour = 12 if hour == 0
  hour_str = hours[hour]
  $(dom).find("#h_#{hour_str}").addClass("active")


style: """
  top: auto
  bottom: 12%
  right: 4%
  left: auto
  width: 45%
  font-family: 'Andale Mono', sans-serif
  color: rgba(145, 145, 145, .2)
  font-weight: 50
  text-align: right
  text-transform: uppercase
  letter-spacing: 0.025em
  font-smoothing: antialiased
  text-shadow: 1px 1px 0px rgba(0, 0, 0, .4)
  line-height: .9em
  font-size: 2.5vw

  .active
    color: rgba(249, 239, 233, 1)
    text-shadow: 1px 1px 0px rgba(0, 0, 0, .9)
"""
