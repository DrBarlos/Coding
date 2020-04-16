function [max_array] = double_array_MaxComparator(array1,array2)
n_arr = length(array1);
max_array = ones(n_arr, 1);

for i = 1:n_arr
    n1 = array1(i);
    n2 = array2(i);
    if n2 >= n1
        max_array(i,1) = n2;
    else
        max_array(i,1) = n1;
    end
end

end

