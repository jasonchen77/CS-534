function H = calcHWithRANSAC(p1, p2)
% Returns the homography that maps p2 to p1 under RANSAC.
% Pre-conditions:
%     Both p1 and p2 are nx2 matrices where each row is a feature point.
%     p1(i, :) corresponds to p2(i, :) for i = 1, 2, ..., n
%     n >= 4
% Post-conditions:
%     Returns H, a 3 x 3 homography matrix

    assert(all(size(p1) == size(p2)));  % input matrices are of equal size
    assert(size(p1, 2) == 2);  % input matrices each have two columns
    assert(size(p1, 1) >= 4);  % input matrices each have at least 4 rows

    %------------- YOUR CODE STARTS HERE -----------------
    % 
    % The following code computes a homography matrix using all feature points
    % of p1 and p2. Modify it to compute a homography matrix using the inliers
    % of p1 and p2 as determined by RANSAC.
    %
    % Your implementation should use the helper function calcH in two
    % places - 1) finding the homography between four point-pairs within
    % the RANSAC loop, and 2) finding the homography between the inliers
    % after the RANSAC loop.
    
    numIter = 100;
    maxDist = 3;
    n = size(p1, 1);
    HBest = zeros(3,3);
    greatestInliers = 0;
    
    for j=1:numIter
        inds = randperm(n,4);
        p1Points = p1(inds,:);
        p2Points = p2(inds,:);
        H1 = calcH(p1Points, p2Points);
        inlierCount = 0;
        inlierP1 = [];
        inlierP2 = [];
        
        % different version of implementation
%         for i=1:n
%             pB = [p2(i, :), 1]';
%             qB = (H1*pB)';
%             qCC = [qB(1,1)/qB(1,3) qB(1,2)/qB(1,3)];
%             pA = p1(i, :);
%             dist = sqrt(((pA(1,1) - qCC(1,1))^2) + ((pA(1,2) - qCC(1,2))^2));
            
            pB = [p2(:, :), ones(size(p2,1),1)]';
            qB = (H1*pB);
            qCC = [qB(1,:)./qB(3,:); qB(2,:)./qB(3,:)];
            qi = [qCC(:, :); ones(1,size(qCC,2))];
            pA = [p1(:, :), ones(size(p2,1),1)]';
            dist = sqrt(sum((pA-qi).^2));
            
            % get inlier counts
            for k=1:size(dist,2)
                if (dist(1,k)<maxDist)
                    inlierCount = inlierCount + 1;
                    inlierP1 = [inlierP1; p1(k, :)];
                    inlierP2 = [inlierP2; p2(k, :)];
                end
            end
        %end
        
        if (greatestInliers<inlierCount)
            greatestInliers = inlierCount;
            HBest = H1;
            inlierP1Best = inlierP1;
            inlierP2Best = inlierP2;
        end
    end
        
    H = calcH(inlierP1Best, inlierP2Best);

    %------------- YOUR CODE ENDS HERE -----------------
end

% The following function has been implemented for you.
% DO NOT MODIFY THE FOLLOWING FUNCTION
function H = calcH(p1, p2)
% Returns the homography that maps p2 to p1 in the least squares sense
% Pre-conditions:
%     Both p1 and p2 are nx2 matrices where each row is a feature point.
%     p1(i, :) corresponds to p2(i, :) for i = 1, 2, ..., n
%     n >= 4
% Post-conditions:
%     Returns H, a 3 x 3 homography matrix
    
    assert(all(size(p1) == size(p2)));
    assert(size(p1, 2) == 2);
    
    n = size(p1, 1);
    if n < 4
        error('Not enough points');
    end
    H = zeros(3, 3);  % Homography matrix to be returned

    A = zeros(n*3,9);
    b = zeros(n*3,1);
    for i=1:n
        A(3*(i-1)+1,1:3) = [p2(i,:),1];
        A(3*(i-1)+2,4:6) = [p2(i,:),1];
        A(3*(i-1)+3,7:9) = [p2(i,:),1];
        b(3*(i-1)+1:3*(i-1)+3) = [p1(i,:),1];
    end
    x = (A\b)';
    H = [x(1:3); x(4:6); x(7:9)];

end
