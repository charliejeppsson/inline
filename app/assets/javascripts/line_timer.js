
function getTimeRemaining(endtime) {
  var t = Date.parse(endtime) - Date.parse(new Date());
  var hours = (t / (1000 * 60 * 60)) % 24;
  lastTimeCount = {
    'total': t,
    'hours': hours
  };
  return lastTimeCount
}

function initializeClock(id, endtime) {
  var clock = document.getElementById(id);
  var hoursSpan = clock.querySelector('.hours');
  // var minutesSpan = clock.querySelector('.minutes');

  function updateClock() {
    var t = getTimeRemaining(endtime);

    if (t.hours > 2.25) {
      hoursSpan.innerHTML = "More than 2 hours left";
    } else if (t.hours <= 2.25 && t.hours > 1.75) {
      hoursSpan.innerHTML = "About 2 hours left";
    } else if (t.hours <= 1.75 && t.hours > 1.25) {
      hoursSpan.innerHTML = "About 1,5 hours left";
    } else if (t.hours <= 1.25 && t.hours > 0.75) {
      hoursSpan.innerHTML = "About 1 hour left";
    } else {
      hoursSpan.innerHTML = "About 0,5 hours left";
    }

    if (t.total <= 0) {
      clearInterval(timeinterval);
      $("#empty-line").removeClass("hidden");
    }
  }

  updateClock();
  // CODE BELOW UPDATEs TIMER EVERY XXXX SECONDS, DOES NOT MATTER IN
  // THIS CASE SINCE THE TIMER IS UPDATED EACH TIME SOMEONE CLICKS A
  // BUTTON THAT CHANGES THE CURRENT_LINE
  var timeinterval = setInterval(updateClock, 1000);
}
