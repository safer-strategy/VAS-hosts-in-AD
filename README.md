# VAS-hosts-in-AD
The purpose of this script is to help identify QAS/VAS hosts in AD. It relies upon the operatingSystem attribute beingset when the host object is created. However, this is not a requirement of QAS or AD to have this attribute populated, and occasionally due to the method used to create the object, it will not be set.

If the attributes are set, the script will count all AD objects. This is usually accurate, as long as defunct Computer objects are routinely removed from AD.

The other number is a count of the "non-windows" hosts in AD, which may include systems that are not running QAS.


