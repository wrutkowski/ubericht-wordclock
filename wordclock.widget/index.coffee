#
# Word Clock widget for Übersicht
# Wojciech Rutkowski (http://wojciech-rutkowski.com/)
# Raphael Hanneken (behoernchen.github.io) code used from Time Words widget
#


#
# Adjust the styles as you like
#
style =
  # Define the maximum width of the widget.
  width: "45%"

  # Define the position, where to display the time.
  # Set properties you don't need to "auto"
  position:
    top:    "auto"
    bottom: "33%"
    left:   "20px"
    right:  "auto"


  # Font properties
  font:                 "'Andale Mono', sans-serif"
  font_color:           "rgba(145, 145, 145, .8)"
  font_color_active:    "rgba(245, 245, 245, 1)"
  font_size:            "2vw"
  font_weight:          "50"
  letter_spacing:       "0.035em"
  line_height:          "1.1em"

  # Text shadow
  text_shadow:
    blur:           "0px"
    x_offset:       "1px"
    y_offset:       "1px"
    color:          "rgba(0, 0, 0, .1)"
    color_active:   "rgba(105, 105, 105, .4)"

  # Misc
  text_transform: "uppercase"


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
  top: #{@style.position.top}
  bottom: #{@style.position.bottom}
  right: #{@style.position.right}
  left: #{@style.position.left}
  width: #{@style.width}
  font-family: #{@style.font}
  color: #{@style.font_color}
  font-weight: #{@style.font_weight}
  text-align: left
  text-transform: uppercase
  font-size: #{@style.font_size}
  letter-spacing: #{@style.letter_spacing}
  font-smoothing: antialiased
  line-height: #{@style.line_height}
  text-shadow: #{@style.text_shadow.x_offset} #{@style.text_shadow.y_offset} #{@style.text_shadow.blur} #{@style.text_shadow.color}

  .active
    color: #{@style.font_color_active}
    text-shadow: #{@style.text_shadow.x_offset} #{@style.text_shadow.y_offset} #{@style.text_shadow.blur} #{@style.text_shadow.color_active}

"""
