spiral = proc do |left, right, top, bottom|
  if left == 5
    []
  else
    left      .upto(right)  .map { |x| [x, top]    } +
    (top+1)   .upto(bottom) .map { |y| [right, y]  } +
    (right-1) .downto(left) .map { |x| [x, bottom] } +
    (bottom-1).downto(top+1).map { |y| [left, y]   } +
    spiral.(left+1, right-1, top+1, bottom-1)
  end
end
p spiral.(1, 13, 1, 13)
