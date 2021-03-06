/*
Jackson Centeno
7/27/21
Problem: Given two sorted arrays nums1 and nums2 of size m and n respectively, return the median of the two sorted arrays.
Proposed Solution: Recursively remove the max and min from total set, until median is left. 
*/

#include <vector>
class Solution {
public:
    double findMedianSortedArrays(std::vector<int>& nums1, std::vector<int>& nums2) {
        if (nums1.size() + nums2.size() == 1)
            return (nums1.size()) ? nums1[0] : nums2[0];
        else if (nums1.size() + nums2.size() == 2) {
            // return the average of the two
            if (nums1.size() == 0)
                return (nums2[0] + nums2[1])/2.0;
            else if (nums2.size() == 0)
                return (nums1[0] + nums1[1])/2.0;
            else
                return (nums1[0] + nums2[0])/2.0;            
        } else {
            // pop the min and max off whichever vector relevant.
            // recursive call
            if (nums1.size() == 0) {
                nums2.pop_back();
                nums2.erase(nums2.begin());
            } else if (nums2.size() == 0) {
                nums1.erase(nums1.begin());
                nums1.pop_back();
            } else {
                (nums1.back() > nums2.back()) ? nums1.pop_back() : nums2.pop_back();
                if (nums1.front() > nums2.front()) {
                    nums2.erase(nums2.begin());
                } else {
                    nums1.erase(nums1.begin());
                }
            }
            return findMedianSortedArrays(nums1, nums2);
        }
    }
};
