from Inverse import *
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--N', type=int, default=50)
parser.add_argument('--k', type = str, default='2')
parser.add_argument('--m', type=int, default=16)
parser.add_argument('--maxq', type=float, default=0.1)
parser.add_argument('--q_method', type=str, default='T')
# parser.add_argument('--noise_level_model', type=float, default=0.0)
parser.add_argument('--noise_level', type=float, default=0.0)
parser.add_argument('--gtol', type=float, default=1e-10)
parser.add_argument('--maxiter', type=int, default=50)
parser.add_argument('--pic_list', type=int,nargs = '*', default=[0,1,2,5,10,-2,-1])
parser.add_argument('--title', type=str, default='tmp')
parser.add_argument('--jpgdir', default='../pic/process_jpg/')
parser.add_argument('--gifdir', default='../pic/process_gif/')
parser.add_argument('--output_filename', type=str, required=True)
# parser.add_argument('--lamb', type=float, default=0.0)
args = parser.parse_args()


N, k, m, maxq, q_method = args.N, args.k, args.m, args.maxq, args.q_method
noise_level, gtol, maxiter, pic_list = args.noise_level, args.gtol, args.maxiter, args.pic_list
title, jpgdir, gifdir, output_filename = args.title, args.jpgdir, args.gifdir, args.output_filename

if isinstance(k,str):
    tmp_k = k.split(',')
    k = [float(eval(item)) for item in tmp_k]

q = q_gen(N, q_method, maxq)
Q = q.reshape(-1, )
Q0 = Q*0
matrix_A = gen_A(N)
Matrix_analysis(N)
partial_data = []
f_list = []
for j in range(len(k)):
    tmpf = f_gen(N, k[j], m)
    f_list.append(tmpf)
    tmp_data = pdata_gen(N, Q, k[j], tmpf, matrix_A)
    tmp_data1 = [Round(item, noise_level) for item in tmp_data]
    partial_data.append(tmp_data1)
# Q0 = Round(Q0, noise_level_model)
args1 = (N, partial_data, k, f_list, matrix_A, maxq)


X_list.append(Q0)
t0 = time.time()
print('start time:%s' % str(datetime.now())[:-7])
RES2 = SOLVE(J_MULTI,Q0=Q0,args=args1,jac=J_MULTIPRIME,
            options={'disp': True,'gtol': gtol,'maxiter': maxiter},
            method='L-BFGS-B')


time_avg = (time.time() - t0) / len(X_list)
ll = len(X_list)
plot_list, label_list, Error_list = [], [], []
for j in range(ll):
    Error_list.append(Error(X_list[j], Q))
    plot_list.append(X_list[j].reshape((N + 1, N + 1)))
    label_list.append('Iter = ' + str(j))
plot_list.append(Q.reshape((N + 1, N + 1)))
label_list.append('Qt')


fp = open(output_filename, 'a+')
print('****************************************************************', file=fp)
print('****************************************************************', file=fp)
print('%s' % str(datetime.now())[:-7], file=fp)
print('N={},m={},k={}'.format(N, m, k), file=fp)
print('gtol={},maxiter={}'.format(gtol, maxiter), file=fp)
print('q_method={},maxq={}'.format(q_method, maxq), file=fp)
print('noise_level={}'.format(noise_level), file=fp)
print('total_iter={},t_avg={:.2f}'.format(len(X_list[1:]), time_avg), file=fp)
print('relative_model_error:', file=fp)
print(Error_list, file=fp)
percent_list = [str(round(Error_list[i]*100,2))+'%' for i in range(len(Error_list))]
percent_list[0] = ''
label_list[0] = 'Init'
percent_list.append('')
fp.close()
plot_heatmap(plot_list, title, jpgdir, gifdir, label_list,percent_list,pic_list)


ctx.destroy()
