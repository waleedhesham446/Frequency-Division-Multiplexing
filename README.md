# Frequency-Division-Multiplexing
Matlab script to simulate the communication preoccess of transmitting receiving signals via modulation and demodulation

## Modulator
Quadrature Amplitude Modulator
1) 1st signal: modulated with frequency = 1/12 of the sample rate (cos carrier)
2) 2nd signal: modulated with frequency = 3/12 of the sample rate (cos carrier)
3) 3rd signal: modulated with frequency = 3/12 of the sample rate (sin carrier)

## Demodulator
Synchronous (Coherent) Demodulator with generated local carrier

## Normal Demodulation

![My Image](figures/1st%20Demodulated.jpg)
![My Image](figures/2nd%20Demodulated.jpg)
![My Image](figures/3rd%20Demodulated.jpg)

## Demodulation with Frequency Shift (1st signal only)

### frequency_shift = 2 HZ
![My Image](figures/Shift%202Hz.jpg)

### frequency_shift = 10 HZ
![My Image](figures/Shift%2010HZ.jpg)

## Demodulation with Phase Shift

### phase_shift = 10 degree
![My Image](figures/First%20Signal%20Phase%20Shift%2010.jpg)
![My Image](figures/2nd%20Demodulated%20Phase%20Shift%2010.jpg)
![My Image](figures/3rd%20Demodulated%20Phase%20Shift%2010.jpg)

### phase_shift = 30 degree
![My Image](figures/First%20Signal%20Phase%20Shift%2030.jpg)
![My Image](figures/2nd%20Demodulated%20Phase%20Shift%2030.jpg)
![My Image](figures/3rd%20Demodulated%20Phase%20Shift%2030.jpg)

### phase_shift = 90 degree
![My Image](figures/First%20Signal%20Phase%20Shift%2090.jpg)
![My Image](figures/2nd%20Demodulated%20Phase%20Shift%2090.jpg)
![My Image](figures/3rd%20Demodulated%20Phase%20Shift%2090.jpg)



#### Contributors
<table>
  <tr>
    <td align="center"><a href="https://github.com/waleedhesham446"><img src="https://avatars.githubusercontent.com/u/72695729?v=4" width="150px;" alt=""/><br /><sub><b>Walid Hesham</b></sub></a><br /></td>
    <td align="center"><a href="https://github.com/MohamedWw"><img src="https://avatars.githubusercontent.com/u/64079821?v=4" width="150px;" alt=""/><br /><sub><b>Mohamed Walid</b></sub></a><br /></td>
     
  </tr>
 </table>
