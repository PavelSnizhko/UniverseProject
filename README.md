# UniverseProject
I changed the timer period for faster testing of the system but for it to work as in the task conditions you need to change  Timer(timeInterval: 2, target: self, selector: #selector(updateTimer), userInfo: universeRule, repeats: true)
from timeIntervar: 2 to timerInterval: 10. Thi constructoor of Timer is located in Universe model.
