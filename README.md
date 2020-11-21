# digi-comm-sys
A MATLAB simulation of a digital communications system

## Description:
Transmitter, channel and receiver in a digital communication system are simulated.

  ### Transmitter:
  1. Bits are generated.
  2. Header bits are added to the beginning of the message.
  3. Message is encoded with Gray or binary coding.
  4. Message is modulated (PAM, PSK or QAM modulation) with a specified pulse shape (rectangular, triangular, sine, raised cosine, root raised cosine or Gaussian) and a specified span for the pulse.

  ### Channel:
  5. Time delay, phase offset and additive white Gaussian noise is added to the signal.

  ### Receiver:
  6. Channel delay is detected by means of the cross correlation of the received signal and the header samples. Using the detected value, the received signal is synchronized.
  7. Phase offset of the channel is detected and compensated.
  8. Signal is demodulated into a sequence of symbols. Minimum distance detection is used.
  9. Resultant symbols are decoded using Gray or binary decoding.
  10. Bit error rate is calculated and plotted.

## Copy Right:
* The files in this repository are the product of the Digital Communications Lab held by Professor A. Olfat in the fall of 2020 at the University of Tehran.
