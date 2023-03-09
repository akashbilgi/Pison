# using a for loop
echo "testing with 1 thread"
for i in {1..5}
do
   /usr/bin/time ../bin/test1 1 >> test_results1.txt
done
echo "completed: testing with 1 thread" 
echo "testing with 2 threads"
for i in {1..5}
do
   /usr/bin/time ../bin/test1 2 >> test_results2.txt
done
echo "completed: testing with 2 threads"
echo "testing with 4 threads"
for i in {1..5}
do
   /usr/bin/time ../bin/test1 4 >> test_results4.txt
done
echo "completed: testing with 4 threads"
echo "testing with 8 threads"
for i in {1..5}
do
   /usr/bin/time ../bin/test1 8 >> test_results8.txt
done
echo "completed: testing with 8 threads"
echo "testing with 16 threads"
for i in {1..5}
do
   /usr/bin/time ../bin/test1 16 >> test_results16.txt
done
echo "completed: testing with 16 threads"
echo "All Done!"
exit 0