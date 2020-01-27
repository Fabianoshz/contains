import time
  
c = 1

while True:
    c = c + 2
    a = c * bytearray(10000000)
    print(c * 10000000)
    time.sleep(1)